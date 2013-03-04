# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/http-replicator/http-replicator-4.0_alpha2.ebuild,v 1.1 2013/03/04 13:00:40 tomwij Exp $

EAPI="5"
PYTHON_DEPEND="2:2.7:2.7" # not 2.6 bug #33907, not 3.0 bug #411083
inherit eutils python

MY_P="${PN}_${PV/_/}"

DESCRIPTION="Proxy cache for Gentoo packages"
HOMEPAGE="http://sourceforge.net/projects/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

src_install(){
	# Daemon and repcacheman into /usr/bin
	exeinto /usr/bin
	doexe http-replicator
	newexe "${FILESDIR}/http-replicator-3.0-callrepcacheman-0.1" repcacheman
	newexe "${FILESDIR}/http-replicator-3.0-repcacheman-0.44-r2" repcacheman.py

	# init.d scripts
	newinitd "${FILESDIR}/http-replicator-3.0.init" http-replicator
	newconfd "${FILESDIR}/http-replicator-3.0.conf" http-replicator

	# not 2.6 bug #33907, not 3.0 bug #411083
	python_convert_shebangs -r 2.7 "${ED}"

	# Docs
	dodoc README.user README.devel RELNOTES
}

pkg_postinst() {
	einfo
	einfo "Before starting http-replicator, please follow the next few steps:"
	einfo "- modify /etc/conf.d/http-replicator if required"
	einfo "- run /usr/bin/repcacheman to set up the cache"
	einfo "- add http_proxy=\"http://serveraddress:8080\" to make.conf on"
	einfo "  the server as well as on the client machines"
	einfo "- make sure GENTOO_MIRRORS in /etc/make.conf starts with several"
	einfo "  good http mirrors"
	einfo
	einfo "For more information please refer to the following forum thread:"
	einfo "  http://forums.gentoo.org/viewtopic-t-173226.html"
	einfo
}
