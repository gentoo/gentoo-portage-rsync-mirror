# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/openresolv/openresolv-3.5.4.ebuild,v 1.1 2013/03/10 22:05:53 floppym Exp $

EAPI=5

inherit base multilib

DESCRIPTION="A framework for managing DNS information"
HOMEPAGE="http://roy.marples.name/projects/openresolv"
SRC_URI="http://roy.marples.name/downloads/${PN}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="systemd"

DEPEND="!net-dns/resolvconf-gentoo
	!<net-dns/dnsmasq-2.40-r1"
RDEPEND="systemd? ( sys-apps/systemd )"

src_configure() {
	local systemd='/usr/bin/systemctl try-restart \1'
	local openrc='if /sbin/rc-service -e \1; then /sbin/rc-service \1 -- -Ds restart; fi'
	econf \
		--prefix= \
		--rundir=/var/run \
		--libexecdir=/$(get_libdir)/resolvconf \
		--restartcmd="$(usex systemd "${systemd}" "${openrc}")"
}

pkg_config() {
	if [ "${ROOT}" != "/" ]; then
		eerror "We cannot configure unless \$ROOT=/"
		return 1
	fi

	if [ -n "$(resolvconf -l)" ]; then
		einfo "${PN} already has DNS information"
	else
		ebegin "Copying /etc/resolv.conf to resolvconf -a dummy"
		resolvconf -a dummy </etc/resolv.conf
		eend $? || return $?
		einfo "The dummy interface will disappear when you next reboot"
	fi
}
