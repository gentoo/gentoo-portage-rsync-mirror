# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/paratype/paratype-1-r2.ebuild,v 1.1 2012/04/25 15:24:22 maksbotan Exp $

EAPI=3

inherit font

DESCRIPTION="ParaType font collection for languages of Russia"
HOMEPAGE="http://www.paratype.com/public/"
SRC_URI="http://www.fontstock.com/public/PTMonoOFL.zip -> ${PN}-mono-${PV}.zip
	http://www.fontstock.com/public/PTSansOFL.zip -> ${PN}-sans-${PV}.zip
	http://www.fontstock.com/public/PTSerifOFL.zip -> ${PN}-serif-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"
