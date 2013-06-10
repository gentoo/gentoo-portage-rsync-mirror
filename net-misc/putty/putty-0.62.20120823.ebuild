# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.62.20120823.ebuild,v 1.2 2013/06/10 20:57:27 jer Exp $

EAPI="4"

inherit autotools eutils toolchain-funcs versionator

MY_PV="$(get_version_component_range 1-2)-2012-08-23"
DESCRIPTION="UNIX port of the famous Telnet and SSH client"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/putty/"
SRC_URI="http://tartarus.org/~simon/${PN}-snapshots/${PN}-${MY_PV}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="doc ipv6 kerberos"

RDEPEND="
	!net-misc/pssh
	dev-libs/glib
	kerberos? ( virtual/krb5 )
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/pango
"
DEPEND="
	${RDEPEND}
	dev-lang/perl
	virtual/pkgconfig
"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	cd "${S}"/unix || die "cd unix failed"
	sed \
		-i configure.ac \
		-e '/AM_PATH_GTK(/d' \
		-e 's|-Wall -Werror||g' || die "sed failed"
	eautoreconf
}

src_configure() {
	cd "${S}"/unix || die "cd failed"
	econf $(use_with kerberos gssapi)
}

src_compile() {
	cd "${S}"/unix || die "cd unix failed"
	emake $(use ipv6 || echo COMPAT=-DNO_IPV6)
}

src_install() {
	if use doc; then
		dodoc doc/puttydoc.txt
		dohtml doc/*.html
	fi

	cd "${S}"/unix
	default

	# install desktop file provided by Gustav Schaffter in #49577
	doicon "${FILESDIR}"/${PN}.xpm
	make_desktop_entry putty PuTTY putty Network
}
