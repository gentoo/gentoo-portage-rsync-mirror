# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/wqy-zenhei/wqy-zenhei-0.9.45.ebuild,v 1.1 2010/09/19 06:24:16 dirtyepic Exp $

EAPI="3"

inherit font

DESCRIPTION="WenQuanYi Hei-Ti Style (sans-serif) Chinese outline font"
HOMEPAGE="http://wqy.sourceforge.net/cgi-bin/enindex.cgi?ZenHei(en)"
SRC_URI="mirror://sourceforge/wqy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"
FONT_S="${S}"
FONT_SUFFIX="ttc"
DOCS="AUTHORS ChangeLog README"

FONT_CONF=(
	43-wqy-zenhei-sharp.conf
	44-wqy-zenhei.conf
)

# Only installs fonts
RESTRICT="strip binchecks"

src_compile() {
	:
}

pkg_postinst() {
	unset FONT_CONF # override default message
	font_pkg_postinst
	elog
	elog "This font installs two fontconfig configuration files."
	elog
	elog "To activate preferred rendering, run:"
	elog "eselect fontconfig enable 44-wqy-zenhei.conf"
	elog
	elog "To make the font only use embedded bitmap fonts when available, run:"
	elog "eselect fontconfig enable 43-wqy-zenhei-sharp.conf"
	elog
}
