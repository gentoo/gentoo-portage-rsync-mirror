# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nabi/nabi-0.99.11.ebuild,v 1.1 2013/05/02 10:43:27 naota Exp $

EAPI=5

DESCRIPTION="Simple Hanguk X Input Method"
HOMEPAGE="https://code.google.com/p/nabi/"
SRC_URI="http://nabi.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug nls"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=x11-libs/gtk+-2.4:2
	>=app-i18n/libhangul-0.1.0
	virtual/libintl"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

DOCS=( AUTHORS ChangeLog ChangeLog.0 NEWS README TODO )

src_configure() {
	local myconf=

	# Broken configure: --disable-debug also enables debug
	use debug && \
		myconf="${myconf} --enable-debug"

	econf ${myconf}
}

src_install() {
	default

	insinto /etc/X11/xinit/xinput.d
	sed -e "s:@EPREFIX@:${EPREFIX}:g" "${FILESDIR}/xinput-${PN}" | newins - "${PN}.conf"
}

pkg_postinst() {
	elog "You MUST add environment variable..."
	elog
	elog "export XMODIFIERS=\"@im=nabi\""
	elog
}
