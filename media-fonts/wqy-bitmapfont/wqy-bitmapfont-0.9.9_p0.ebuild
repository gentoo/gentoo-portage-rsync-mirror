# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/wqy-bitmapfont/wqy-bitmapfont-0.9.9_p0.ebuild,v 1.10 2014/04/07 05:05:26 naota Exp $

inherit font

DESCRIPTION="WenQuanYi Bitmap Song CJK font"
HOMEPAGE="http://wenq.org/wqy2/index.cgi?Home"
SRC_URI="mirror://sourceforge/wqy/${PN}-pcf-${PV/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}
FONT_S=${S}
FONT_CONF=( "85-wqy-bitmapsong.conf" )

FONT_SUFFIX="pcf"
DOCS="AUTHORS ChangeLog README"

# Only installs fonts
RESTRICT="strip binchecks"
