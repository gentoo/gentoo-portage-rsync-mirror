# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/unbound/unbound-1.4.21-r2.ebuild,v 1.1 2014/05/13 19:17:43 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils flag-o-matic multilib-minimal python-single-r1 systemd user

DESCRIPTION="A validating, recursive and caching DNS resolver"
HOMEPAGE="http://unbound.net/"
SRC_URI="http://unbound.net/downloads/${P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~x86 ~x64-macos"
IUSE="debug gost python selinux static-libs test threads"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# Note: expat is needed by executable only but the Makefile is custom
# and doesn't make it possible to easily install the library without
# the executables. MULTILIB_USEDEP may be dropped once build system
# is fixed.

RDEPEND="dev-libs/expat[${MULTILIB_USEDEP}]
	dev-libs/libevent[${MULTILIB_USEDEP}]
	>=dev-libs/openssl-0.9.8[${MULTILIB_USEDEP}]
	>=net-libs/ldns-1.6.13[ecdsa,ssl,gost?,${MULTILIB_USEDEP}]
	python? ( ${PYTHON_DEPS} )
	selinux? ( sec-policy/selinux-bind )"

DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	test? (
		net-dns/ldns-utils[examples]
		dev-util/splint
		app-text/wdiff
	)"

# bug #347415
RDEPEND="${RDEPEND}
	net-dns/dnssec-root"

pkg_setup() {
	enewgroup unbound
	enewuser unbound -1 -1 /etc/unbound unbound

	use python && python-single-r1_pkg_setup
}

src_prepare() {
	# To avoid below error messages, set 'trust-anchor-file' to same value in
	# 'auto-trust-anchor-file'.
	# [23109:0] error: Could not open autotrust file for writing,
	# /etc/dnssec/root-anchors.txt: Permission denied
	epatch "${FILESDIR}"/${PN}-1.4.12-gentoo.patch

	# required for the python part
	multilib_copy_sources
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	multilib-minimal_src_configure
}

multilib_src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable gost) \
		$(use_enable static-libs static) \
		$(multilib_native_use_with python pythonmodule) \
		$(multilib_native_use_with python pyunbound) \
		$(use_with threads pthreads) \
		--disable-rpath \
		--enable-ecdsa \
		--with-ldns="${EPREFIX}"/usr \
		--with-libevent="${EPREFIX}"/usr \
		--with-pidfile="${EPREFIX}"/var/run/unbound.pid \
		--with-rootkey-file="${EPREFIX}"/etc/dnssec/root-anchors.txt

		# http://unbound.nlnetlabs.nl/pipermail/unbound-users/2011-April/001801.html
		# $(use_enable debug lock-checks) \
		# $(use_enable debug alloc-checks) \
		# $(use_enable debug alloc-lite) \
		# $(use_enable debug alloc-nonregional) \
}

multilib_src_install_all() {
	prune_libtool_files --modules
	use python && python_optimize

	newinitd "${FILESDIR}"/unbound.initd unbound
	newconfd "${FILESDIR}"/unbound.confd unbound

	systemd_dounit "${FILESDIR}"/unbound.service
	systemd_newunit "${FILESDIR}"/unbound_at.service "unbound@.service"
	systemd_dounit "${FILESDIR}"/unbound-anchor.service

	dodoc doc/{README,CREDITS,TODO,Changelog,FEATURES}

	# bug #315519
	dodoc contrib/unbound_munin_

	docinto selinux
	dodoc contrib/selinux/*

	exeinto /usr/share/${PN}
	doexe contrib/update-anchor.sh
}
