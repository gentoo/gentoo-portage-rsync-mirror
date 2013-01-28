# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils-meta/kdeutils-meta-4.9.5.ebuild,v 1.4 2013/01/27 23:25:05 ago Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="kdeutils - merge this to pull in all kdeutils-derived packages"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE="cups floppy lirc"

RDEPEND="
	$(add_kdebase_dep ark)
	$(add_kdebase_dep filelight)
	$(add_kdebase_dep kcalc)
	$(add_kdebase_dep kcharselect)
	$(add_kdebase_dep kdf)
	$(add_kdebase_dep kgpg)
	$(add_kdebase_dep ktimer)
	$(add_kdebase_dep kwallet)
	$(add_kdebase_dep superkaramba)
	$(add_kdebase_dep sweeper)
	cups? ( $(add_kdebase_dep printer-applet) )
	floppy? ( $(add_kdebase_dep kfloppy) )
	lirc? ( $(add_kdebase_dep kremotecontrol) )
"
