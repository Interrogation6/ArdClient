/*
 *  This file is part of the Haven & Hearth game client.
 *  Copyright (C) 2009 Fredrik Tolf <fredrik@dolda2000.com>, and
 *                     Björn Johannessen <johannessen.bjorn@gmail.com>
 *
 *  Redistribution and/or modification of this file is subject to the
 *  terms of the GNU Lesser General Public License, version 3, as
 *  published by the Free Software Foundation.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  Other parts of this source tree adhere to other copying
 *  rights. Please see the file `COPYING' in the root directory of the
 *  source tree for details.
 *
 *  A copy the GNU Lesser General Public License is distributed along
 *  with the source tree of which this file is a part in the file
 *  `doc/LPGL-3'. If it is missing for any reason, please see the Free
 *  Software Foundation's website at <http://www.fsf.org/>, or write
 *  to the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 *  Boston, MA 02111-1307 USA
 */

package haven;

import java.awt.image.BufferedImage;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public abstract class GSprite implements Drawn {
    public final Owner owner;
    public static final List<Factory> factories;

    static {
        factories = Arrays.asList(new Factory[]{
                StaticGSprite.fact,
        });
    }

    public interface Owner extends OwnerContext {
        Random mkrandoom();

        Resource getres();

        @Deprecated
        default Glob glob() {
            return (context(Glob.class));
        }
    }

    public interface ImageSprite {
        BufferedImage image();
    }

    public GSprite(Owner owner) {
        this.owner = owner;
    }

    public static class FactMaker extends Resource.PublishedCode.Instancer.Chain<Factory> {
        public FactMaker() {
            super(Factory.class);
            add(new Direct<>(Factory.class));
            add(new StaticCall<>(Factory.class, "mkgsprite", GSprite.class, new Class<?>[]{Owner.class, Resource.class, Message.class}, (make) -> (owner, res, sdt) -> make.apply(new Object[]{owner, res, sdt})));
            add(new Construct<>(Factory.class, GSprite.class, new Class<?>[]{Owner.class, Resource.class, Message.class}, (cons) -> (owner, res, sdt) -> cons.apply(new Object[]{owner, res, sdt})));
        }
    }

    @Resource.PublishedCode(name = "ispr", instancer = FactMaker.class)
    public interface Factory {
        GSprite create(Owner owner, Resource res, Message sdt);
    }

    public static GSprite create(Owner owner, Resource res, Message sdt) {
        if (res instanceof Resource.FakeResource) {
            return (new FakeGSprite(owner, res, sdt));
        }
        if (res.name.equals("gfx/invobjs/parchment-decal")) {
            return (new modification.DecalItem(owner, res, sdt));
        }
        {
            Factory f = res.getcode(Factory.class, false);
            if (f != null)
                return (f.create(owner, res, sdt));
        }
        for (Factory f : factories) {
            GSprite ret = f.create(owner, res, sdt);
            if (ret != null)
                return (ret);
        }
        throw (new Sprite.ResourceException("Does not know how to draw resource " + res.name, res));
    }

    public abstract void draw(GOut g);
    public void draw(GOut g, Coord sz) {
        draw(g);
    }
    public abstract Coord sz();

    public void tick(double dt) {
    }

    public String getname() {
        Class cl = this.getClass();
        try {
            Field name = cl.getDeclaredField("name");
            return (String) name.get(this);
        } catch (NoSuchFieldException nsfe) {
        } catch (ClassCastException cce) {
        } catch (IllegalAccessException iae) {
        }
        return null;
    }


    public static class FakeGSprite extends GSprite {
        public final Resource res;
        public final byte[] data;

        public FakeGSprite(Owner owner, Resource res, Message sdt) {
            super(owner);
            this.res = res;
            this.data = sdt.bytes();
        }

        @Override
        public void draw(GOut g) {
            g.image(res.layer(Resource.imgc).tex(), Coord.z, sz());
        }

        @Override
        public Coord sz() {
            return (Coord.o.mul(UI.scale(30)));
        }
    }
}
