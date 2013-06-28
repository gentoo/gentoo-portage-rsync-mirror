# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.62.20120823-r1.ebuild,v 1.1 2013/06/28 14:22:48 jer Exp $

EAPI="4"

inherit autotools eutils gnome2-utils toolchain-funcs versionator

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
	cd "${S}"/unix || die
	sed \
		-i configure.ac \
		-e '/AM_PATH_GTK(/d' \
		-e 's|-Wall -Werror||g' || die
	eautoreconf
}

src_configure() {
	cd "${S}"/unix || die
	econf $(use_with kerberos gssapi)
}

src_compile() {
	cd "${S}"/unix || die
	emake $(usex ipv6 '' COMPAT=-DNO_IPV6)

	cd "${S}"/icons || die
	for i in 16 22 24 32 48 64 128 256; do
		./mkicon.py  putty_icon ${i} putty-${i}.png || die
	done
}

src_install() {
	if use doc; then
		dodoc doc/puttydoc.txt
		dohtml doc/*.html
	fi

	cd "${S}"/unix || die
	default

	# install desktop file provided by Gustav Schaffter in #49577
	cd "${S}"/icons || die
	for i in 16 22 24 32 48 64 128 256; do
		newicon -s ${i} putty-${i}.png putty.png
	done

	make_desktop_entry putty PuTTY putty Network
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
