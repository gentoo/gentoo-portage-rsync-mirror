# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/cppzmq/cppzmq-0_pre130717-r1.ebuild,v 1.1 2013/07/22 14:07:27 jlec Exp $

EAPI=5

DESCRIPTION="CPPZMQ - High-level C Binding for ZeroMQ"
HOMEPAGE="https://github.com/zeromq/cppzmq"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="net-libs/zeromq"
DEPEND=""

src_install() {
	doheader zmq.hpp
	dodoc README
}
