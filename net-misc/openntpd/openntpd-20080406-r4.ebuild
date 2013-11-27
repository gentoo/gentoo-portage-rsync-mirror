# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openntpd/openntpd-20080406-r4.ebuild,v 1.6 2013/11/27 21:08:21 maekke Exp $

EAPI=5

inherit autotools eutils toolchain-funcs systemd user

MY_P="${P/-/_}p"
DEB_VER="4"
DESCRIPTION="Lightweight NTP server ported from OpenBSD"
HOMEPAGE="http://www.openntpd.org/"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${MY_P}-${DEB_VER}.debian.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="ssl selinux"

RDEPEND="ssl? ( dev-libs/openssl )
	selinux? ( sec-policy/selinux-ntp )
	!<=net-misc/ntp-4.2.0-r2
	!net-misc/ntp[-openntpd]"
DEPEND="${RDEPEND}
	virtual/yacc"

S="${WORKDIR}/${MY_P/_/-}"

pkg_setup() {
	export NTP_HOME="${NTP_HOME:=/var/lib/openntpd/chroot}"
	enewgroup ntp
	enewuser ntp -1 -1 "${NTP_HOME}" ntp

	# make sure user has correct HOME as flipng between
	# the standard ntp pkg and this one was possible in
	# the past
	if [[ $(egethome ntp) != ${NTP_HOME} ]]; then
		ewarn "From this version on, the homedir of the ntp user cannot be changed"
		ewarn "dynamically after the installation. For homedir different from"
		ewarn "/var/lib/openntpd/chroot set NTP_HOME in your make.conf and re-emerge."
		esethome ntp "${NTP_HOME}"
	fi
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

	newinitd "${FILESDIR}/${PN}.init.d-${PVR}" ntpd
	newconfd "${FILESDIR}/${PN}.conf.d-${PV}-r3" ntpd

	systemd_newunit "${FILESDIR}/${PN}.service-${PV}-r3" ntpd.service
}

pkg_postinst() {
	# remove localtime file from previous installations
	rm -f "${EROOT}${NTP_HOME}"/etc/localtime
	mkdir -p "${NTP_HOME}"/etc
	ln -s /etc/localtime "${NTP_HOME}"/etc/localtime || die
	chown -R root:root "${EROOT}${NTP_HOME}" || die
}

pkg_postrm() {
	# remove localtime file from previous installations
	rm -f "${EROOT}${NTP_HOME}"/etc/localtime
}
