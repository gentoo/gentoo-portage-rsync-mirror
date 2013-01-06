# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/radvd/radvd-1.9.1-r1.ebuild,v 1.6 2012/09/19 22:44:02 jer Exp $

EAPI=4

inherit user

DESCRIPTION="Linux IPv6 Router Advertisement Daemon"
HOMEPAGE="http://v6web.litech.org/radvd/"
SRC_URI="http://v6web.litech.org/radvd/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc sparc x86 ~x86-fbsd"
IUSE="kernel_FreeBSD selinux"

RDEPEND="dev-libs/libdaemon
	selinux? ( sec-policy/selinux-radvd )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig"

DOCS=( CHANGES README TODO radvd.conf.example )

pkg_setup() {
	enewgroup radvd
	enewuser radvd -1 -1 /dev/null radvd

	# force ownership of radvd user and group (bug #19647)
	[[ -d ${ROOT}/var/run/radvd ]] && chown radvd:radvd "${ROOT}"/var/run/radvd
}

src_configure() {
	econf --with-pidfile=/var/run/radvd/radvd.pid
}

src_install() {
	default

	dohtml INTRO.html

	newinitd "${FILESDIR}"/${P}.init ${PN}
	newconfd "${FILESDIR}"/${PN}.conf ${PN}

	# location of radvd.pid needs to be writeable by the radvd user
	keepdir /var/run/radvd
	fowners -R radvd:radvd /var/run/radvd
	fperms 755 /var/run/radvd

	if use kernel_FreeBSD ; then
		sed -i -e \
			's/^SYSCTL_FORWARD=.*$/SYSCTL_FORWARD=net.inet6.ip6.forwarding/g' \
			"${D}"/etc/init.d/${PN} || die
	fi
}

pkg_postinst() {
	elog
	elog "To use ${PN} you must create the configuration file"
	elog "${ROOT}etc/radvd.conf"
	elog
	elog "An example configuration file has been installed under"
	elog "${ROOT}usr/share/doc/${PF}"
	elog
	elog "grsecurity users should allow a specific group to read /proc"
	elog "and add the radvd user to that group, otherwise radvd may"
	elog "segfault on startup."
}
