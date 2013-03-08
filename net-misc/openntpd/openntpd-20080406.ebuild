# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openntpd/openntpd-20080406.ebuild,v 1.5 2013/03/08 17:44:19 ago Exp $

EAPI=5

inherit autotools eutils toolchain-funcs user

MY_P="${P/-/_}p"
DEB_VER="4"
DESCRIPTION="Lightweight NTP server ported from OpenBSD"
HOMEPAGE="http://www.openntpd.org/"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${MY_P}-${DEB_VER}.debian.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="ssl selinux"

RDEPEND="ssl? ( dev-libs/openssl )
	selinux? ( sec-policy/selinux-ntp )
	!<=net-misc/ntp-4.2.0-r2
	!net-misc/ntp[-openntpd]"
DEPEND="${RDEPEND}
	virtual/yacc"

S="${WORKDIR}/${MY_P/_/-}"

pkg_setup() {
	enewgroup ntp
	enewuser ntp -1 -1 /var/lib/openntpd/chroot ntp

	# make sure user has correct HOME when flipping between
	# the standard ntp pkg and this one
	usermod -d /var/lib/openntpd/chroot ntp || die
}

src_prepare() {
	sed -i '/NTPD_USER/s:_ntp:ntp:' ntpd.h || die

	epatch "${WORKDIR}"/debian/patches/*.patch
	sed -i 's:debian:gentoo:g' ntpd.conf || die
	eautoreconf # deb patchset touches .ac files and such
}

src_configure() {
	econf \
		--disable-strip \
		$(use_with !ssl builtin-arc4random) \
		AR="$(type -p $(tc-getAR))"
}

src_install() {
	default

	newinitd "${FILESDIR}/openntpd.init.d-3.9_p1-r4" ntpd
	newconfd "${FILESDIR}/openntpd.conf.d-3.9_p1-r4" ntpd
}
