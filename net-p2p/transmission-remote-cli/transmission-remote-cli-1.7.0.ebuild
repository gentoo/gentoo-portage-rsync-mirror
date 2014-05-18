# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission-remote-cli/transmission-remote-cli-1.7.0.ebuild,v 1.1 2014/05/18 08:00:50 xmw Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="ncurses"
inherit bash-completion-r1 python-r1

DESCRIPTION="Ncurses interface for the Transmission BitTorrent client"
HOMEPAGE="https://github.com/fagga/transmission-remote-cli/"
SRC_URI="https://github.com/fagga/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="geoip rdns"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	geoip? ( dev-python/geoip-python[$PYTHON_USEDEP] )
	rdns? ( dev-python/adns-python[$PYTHON_USEDEP] )"

src_install() {
	python_foreach_impl python_doscript transmission-remote-cli
	newbashcomp completion/bash/transmission-remote-cli-bash-completion.sh \
		transmission-remote-cli
	doman transmission-remote-cli.1
	dodoc NEWS README.md
}
