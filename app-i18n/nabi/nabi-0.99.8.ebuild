# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nabi/nabi-0.99.8.ebuild,v 1.2 2012/05/03 19:24:27 jdhore Exp $

EAPI=3

DESCRIPTION="Simple Hanguk X Input Method"
HOMEPAGE="http://nabi.kldp.net/"
SRC_URI="http://kldp.net/frs/download.php/5865/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug nls"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=x11-libs/gtk+-2.4:2
	>=app-i18n/libhangul-0.0.12
	virtual/libintl"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_configure() {
	local myconf=

	# Broken configure: --disable-debug also enables debug
	use debug && \
		myconf="${myconf} --enable-debug"

	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	sed -e "s:@EPREFIX@:${EPREFIX}:g" "${FILESDIR}/xinput-${PN}" > "${T}/${PN}.conf" || die
	insinto /etc/X11/xinit/xinput.d
	doins "${T}/${PN}.conf" || die

	dodoc AUTHORS ChangeLog* NEWS README TODO || die
}

pkg_postinst() {
	elog "You MUST add environment variable..."
	elog
	elog "export XMODIFIERS=\"@im=nabi\""
	elog
}
