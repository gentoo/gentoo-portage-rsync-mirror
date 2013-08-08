# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.63.ebuild,v 1.6 2013/08/08 12:33:45 ago Exp $

EAPI=5

inherit autotools eutils gnome2-utils toolchain-funcs versionator

DESCRIPTION="A Free Telnet/SSH Client"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/putty/"
SRC_URI="
	http://the.earth.li/~sgtatham/${PN}/latest/${P}.tar.gz
	http://dev.gentoo.org/~jer/${PN}-icons.tar.bz2"
LICENSE="MIT"

SLOT="0"
KEYWORDS="alpha amd64 ~hppa ppc sparc x86"
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

src_prepare() {
	cd "${S}"/unix || die
	sed -i \
		-e '/AM_PATH_GTK(/d' \
		-e 's|-Wall -Werror||g' \
		configure.ac || die

	eautoreconf
}

src_configure() {
	cd "${S}"/unix || die
	econf $(use_with kerberos gssapi)
}

src_compile() {
	cd "${S}"/unix || die
	emake AR=$(tc-getAR) $(usex ipv6 '' COMPAT=-DNO_IPV6)
}

src_install() {
	dodoc doc/puttydoc.txt

	if use doc; then
		dohtml doc/*.html
	fi

	cd "${S}"/unix || die
	default

	for i in 16 22 24 32 48 64 128 256; do
		newicon -s ${i} "${WORKDIR}"/${PN}-icons/${PN}-${i}.png ${PN}.png
	done

	# install desktop file provided by Gustav Schaffter in #49577
	make_desktop_entry ${PN} PuTTY ${PN} Network
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
