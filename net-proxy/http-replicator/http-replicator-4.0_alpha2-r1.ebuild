# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/http-replicator/http-replicator-4.0_alpha2-r1.ebuild,v 1.1 2013/06/05 13:32:57 tomwij Exp $

EAPI="5"

# Not 2.6, see bug #33907; not 3.0, see bug #411083.
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1

MY_P="${PN}_${PV/_/}"

DESCRIPTION="Proxy cache for Gentoo packages"
HOMEPAGE="http://sourceforge.net/projects/http-replicator"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

S="${WORKDIR}/${MY_P}"

# Tests downloads files as well as breaks, should be turned into local tests.
RESTRICT="test"

src_test() {
	./unit-test && die
}

src_install(){
	python_export python2_7 EPYTHON PYTHON PYTHON_SITEDIR

	exeinto /usr/bin
	doexe http-replicator

	newexe "${FILESDIR}"/${PN}-3.0-callrepcacheman-0.1 repcacheman
	newexe "${FILESDIR}"/${PN}-3.0-repcacheman-0.44-r2 repcacheman.py

	python_domodule *.py

	newinitd "${FILESDIR}"/${PN}-3.0.init http-replicator
	newconfd "${FILESDIR}"/${PN}-3.0.conf http-replicator

	# Not 2.6, see bug #33907; not 3.0, see bug #411083.
	# python_convert_shebangs -r 2.7 "${ED}"

	dodoc README.user README.devel RELNOTES
}

pkg_postinst() {
	einfo
	einfo "Before starting ${PN}, please follow the next few steps:"
	einfo "- modify /etc/conf.d/${PN} if required"
	einfo "- run \`repcacheman\` to set up the cache"
	einfo "- add http_proxy=\"http://serveraddress:8080\" to make.conf on"
	einfo "  the server as well as on the client machines"
	einfo "- make sure GENTOO_MIRRORS in /etc/portage/make.conf"
	einfo "  starts with several good http mirrors"
	einfo
	einfo "For more information please refer to the following forum thread:"
	einfo "  http://forums.gentoo.org/viewtopic-t-173226.html"
	einfo
}
