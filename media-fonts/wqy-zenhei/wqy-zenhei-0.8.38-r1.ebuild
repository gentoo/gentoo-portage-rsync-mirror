# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/wqy-zenhei/wqy-zenhei-0.8.38-r1.ebuild,v 1.4 2009/09/27 10:22:00 volkmar Exp $

inherit font

MY_P="${P/_p/-cvs}-1"
DESCRIPTION="WenQuanYi Hei-Ti Style (sans-serif) Chinese outline font"
HOMEPAGE="http://wenq.org/enindex.cgi"
SRC_URI="mirror://sourceforge/wqy/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

# Only installs fonts
RESTRICT="strip binchecks"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"
FONT_S="${S}"
FONT_CONF=(
	"44-wqy-zenhei.conf"
	"66-wqy-zenhei-sharp.conf"
	"66-wqy-zenhei-sharp-no13px.conf"
)

FONT_SUFFIX="ttc"
DOCS="AUTHORS ChangeLog README"

pkg_postinst() {
	font_pkg_postinst
	elog
	elog "This font installs two fontconfig configuration files."
	elog ""
	elog "To activate preferred rendering, run:"
	elog "eselect fontconfig enable 44-wqy-zenhei.conf"
	elog
	elog "To make the font only use embedded bitmap fonts when available, run:"
	elog "eselect fontconfig enable 66-wqy-zenhei-sharp.conf"
	elog
}
