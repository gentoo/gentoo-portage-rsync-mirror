# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kpovmodeler/kpovmodeler-1.1.3.ebuild,v 1.4 2011/10/28 23:55:16 abcd Exp $

EAPI=4
KDE_LINGUAS="af ar be bg br ca cs cy da de el en_GB es et eu fa fi fr ga gl he
hi hr hu is it ja km lt mk ms nb nds ne nl nn oc pl pt pt_BR ro ru se sk sl sv
ta tg tr uk vi xh zh_CN zh_TW"
inherit kde4-base

MY_P=${P}-kde4.1.1

DESCRIPTION="A modeling and composition program for creating POV-Ray(TM) scenes"
HOMEPAGE="http://www.kpovmodeler.org/"
SRC_URI="http://www.kpovmodeler.org/files/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="media-gfx/povray"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS BUGS ChangeLog README StyleConvention TODO )

PATCHES=( "${FILESDIR}/${P}-underlinking.patch" )
