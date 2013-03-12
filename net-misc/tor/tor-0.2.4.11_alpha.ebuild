# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tor/tor-0.2.4.11_alpha.ebuild,v 1.1 2013/03/12 12:30:48 blueness Exp $

EAPI="4"

inherit eutils flag-o-matic versionator

MY_PV="$(replace_version_separator 4 -)"
MY_PF="${PN}-${MY_PV}"
DESCRIPTION="Anonymizing overlay network for TCP"
HOMEPAGE="http://www.torproject.org/"
SRC_URI="https://archive.torproject.org/tor-package-archive/${MY_PF}.tar.gz"
S="${WORKDIR}/${MY_PF}"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="-bufferevents nat-pmp selinux stats tor-hardening transparent-proxy threads upnp web"

DEPEND="dev-libs/openssl
	sys-libs/zlib
	dev-libs/libevent
	nat-pmp? ( net-libs/libnatpmp )
	upnp? ( net-libs/miniupnpc )
	selinux? ( sec-policy/selinux-tor )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup tor
	enewuser tor -1 -1 /var/lib/tor tor
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.2.3.14_alpha-torrc.sample.patch
}

src_configure() {
	# Upstream isn't sure of all the user provided CFLAGS that
	# will break tor, but does recommend against -fstrict-aliasing.
	# We'll filter-flags them here as we encounter them.
	filter-flags -fstrict-aliasing
	econf \
		--disable-buf-freelists \
		--enable-asciidoc \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable stats instrument-downloads) \
		$(use_enable bufferevents) \
		$(use_enable nat-pmp) \
		$(use_enable tor-hardening gcc-hardening) \
		$(use_enable tor-hardening linker-hardening) \
		$(use_enable transparent-proxy transparent) \
		$(use_enable threads) \
		$(use_enable upnp) \
		$(use_enable web tor2web-mode)
}

src_install() {
	newconfd "${FILESDIR}"/tor.confd tor
	newinitd "${FILESDIR}"/tor.initd-r6 tor

	emake DESTDIR="${D}" install

	keepdir /var/lib/tor

	dodoc README ChangeLog ReleaseNotes \
		doc/{HACKING,spec/README}

	fperms 750 /var/lib/tor
	fowners tor:tor /var/lib/tor

	insinto /etc/tor/
	newins "${FILESDIR}"/torrc-r1 torrc
}

pkg_postinst() {
	elog
	elog "We created a configuration file for tor, /etc/tor/torrc, but you can"
	elog "change it according to your needs.  Use the torrc.sample that is in"
	elog "that directory as a guide.  Also, to have privoxy work with tor"
	elog "just add the following line"
	elog
	elog "forward-socks4a / localhost:9050 ."
	elog
	elog "to /etc/privoxy/config.  Notice the . at the end!"
	elog
}
