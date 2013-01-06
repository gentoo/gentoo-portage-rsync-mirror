# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openbsd-netcat/openbsd-netcat-1.84.ebuild,v 1.2 2012/11/01 07:40:52 heroxbd Exp $

EAPI=4

inherit eutils toolchain-funcs rpm

DESCRIPTION="the OpenBSD network swiss army knife"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/src/usr.bin/nc/"
SRC_URI="ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Server/en/os/SRPMS/nc-1.84-22.el6.src.rpm"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="static"

DEPEND="dev-libs/glib:2"
RDEPEND="${DEPEND}"

S=${WORKDIR}/nc

src_unpack() {
	rpm_src_unpack
}

src_prepare() {
	epatch "../nc-1.84-glib.patch"
	epatch "../nc-1.78-pollhup.patch"
	epatch "../nc-1.82-reuseaddr.patch"
	epatch "../nc-gcc_signess.patch"
	epatch "../nc-1.84-connect_with_timeout.patch"
	epatch "../nc-1.84-udp_stop.patch"
	epatch "../nc-1.84-udp_port_scan.patch"
	epatch "../nc-1.84-crlf.patch"
	epatch "../nc-1.84-verb.patch"
	epatch "../nc-1.84-man.patch"
	epatch "../nc-1.84-gcc4.3.patch"
	epatch "../nc-1.84-efficient_reads.patch"
	epatch "../nc-1.84-verbose-segfault.patch"

	# avoid name conflict against net-analyzer/netcat
	mv nc.1 nc.openbsd.1
}

src_compile() {
	use static && export STATIC="-static"
	COMPILER=$(tc-getCC)
	${COMPILER} ${CFLAGS} $(pkg-config --cflags --libs glib-2.0) netcat.c \
	atomicio.c socks.c -o nc.openbsd || die
}

src_install() {
	dobin nc.openbsd
	dodoc README*
	doman nc.openbsd.1
	docinto scripts
	dodoc scripts/*
}
