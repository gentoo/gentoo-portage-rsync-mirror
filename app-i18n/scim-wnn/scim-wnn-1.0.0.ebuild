# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-wnn/scim-wnn-1.0.0.ebuild,v 1.5 2012/10/02 02:40:49 naota Exp $

EAPI=2

DESCRIPTION="Japanese input method Wnn IMEngine for SCIM"
HOMEPAGE="http://nop.net-p.org/modules/pukiwiki/index.php?%5B%5Bscim-wnn%5D%5D"
SRC_URI="http://nop.net-p.org/files/scim-wnn/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="freewnn"

RDEPEND="|| ( >=app-i18n/scim-1.0[-gtk3] >=app-i18n/scim-cvs-1.0 )
	dev-libs/wnn7sdk
	freewnn? ( app-i18n/freewnn )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	sed -i -e 's:$LDFLAGS conftest.$ac_ext $LIBS:conftest.$ac_ext $LIBS $LDFLAGS:g' \
		configure || die "ldflags sed failed"
	cd "${S}"/src
	sed -i -e "s:/usr/lib/wnn7:/usr/lib/wnn:g" \
		scim_wnn_def.h wnnconversion.cpp || die "sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS THANKS README
}

pkg_postinst() {
	elog
	elog "To use SCIM with both GTK2 and XIM, you should use the following"
	elog "in your user startup scripts such as .gnomerc or .xinitrc:"
	elog
	elog "LANG='your_language' scim -d"
	elog "export XMODIFIERS=@im=SCIM"
	elog
	if ! use freewnn ; then
	ewarn
	ewarn "You disabled freewnn USE flag."
	ewarn "Please make sure you have wnnenvrc visible to scim-wnn."
	ewarn
	fi
}
