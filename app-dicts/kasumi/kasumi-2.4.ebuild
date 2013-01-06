# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/kasumi/kasumi-2.4.ebuild,v 1.3 2012/05/03 02:18:37 jdhore Exp $

EAPI="1"

DESCRIPTION="Anthy dictionary maintenance tool"
HOMEPAGE="http://kasumi.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/37311/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.4:2
	nls? ( virtual/libintl )
	virtual/libiconv
	>=app-i18n/anthy-6131"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README ChangeLog AUTHORS
}
