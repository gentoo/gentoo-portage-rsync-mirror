# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/petrify/petrify-4.2.ebuild,v 1.7 2013/01/13 19:14:41 ulm Exp $

DESCRIPTION="Synthesize Petri nets into asynchronous circuits"
HOMEPAGE="http://www.lsi.upc.edu/~jordicf/petrify/"
SRC_URI="http://www.lsi.upc.edu/~jordicf/petrify/distrib/petrify-4.2-linux.tgz"

LICENSE="Old-MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

RDEPEND="media-gfx/graphviz"

src_install () {
	cd ${WORKDIR}/petrify
	dodir /opt/petrify
	exeinto /opt/petrify
	doexe bin/petrify
	dosym /opt/petrify/petrify /opt/petrify/draw_astg
	dosym /opt/petrify/petrify /opt/petrify/write_sg
	dodoc doc/*
	doman man/man1/*
	cp -pPR lib/petrify.lib ${D}/opt/petrify
	dodir /etc/env.d
	echo "PATH=/opt/petrify" > ${D}/etc/env.d/00petrify
}
