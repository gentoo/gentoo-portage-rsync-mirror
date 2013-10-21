# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/roboto/roboto-20120823.ebuild,v 1.2 2013/10/21 12:16:29 grobian Exp $

inherit font

MY_PN="Roboto_Hinted_${PV}"

DESCRIPTION="Standard font for Android 4.0 (Ice Cream Sandwich) and later"
HOMEPAGE="http://developer.android.com/design/style/typography.html"
SRC_URI="http://developer.android.com/downloads/design/${MY_PN}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE=""

S="${WORKDIR}/"
FONT_S="${S}"
FONT_SUFFIX="ttf"
