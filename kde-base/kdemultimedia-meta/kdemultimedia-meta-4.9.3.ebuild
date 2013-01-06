# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-meta/kdemultimedia-meta-4.9.3.ebuild,v 1.4 2012/11/30 15:42:40 ago Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="kdemultimedia - merge this to pull in all kdemultimedia-derived packages"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="ffmpeg +mplayer"

RDEPEND="
	$(add_kdebase_dep dragon)
	$(add_kdebase_dep juk)
	$(add_kdebase_dep audiocd-kio)
	$(add_kdebase_dep kmix)
	$(add_kdebase_dep kscd)
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	mplayer? ( $(add_kdebase_dep mplayerthumbs) )
	ffmpeg? ( $(add_kdebase_dep ffmpegthumbs) )
"
