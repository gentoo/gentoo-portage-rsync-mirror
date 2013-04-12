# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/geneweb/geneweb-6.02.ebuild,v 1.1 2013/04/12 09:13:27 tupone Exp $

EAPI=4
inherit eutils user

MY_PN=gw
MY_P=${MY_PN}-${PV}

DESCRIPTION="Genealogy software program with a Web interface."
HOMEPAGE="http://opensource.geneanet.org/projects/geneweb"
SRC_URI="http://opensource.geneanet.org/attachments/download/126/${MY_P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-lang/ocaml[ocamlopt?]
	dev-ml/camlp5"
DEPEND="${RDEPEND}
	!net-p2p/ghostwhitecrab"

S=${WORKDIR}/${MY_P}-src

src_prepare() {
	esvn_clean
	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-amd64.patch \
		"${FILESDIR}"/${P}-parallellbuild.patch
	cp tools/Makefile.inc.unix tools/Makefile.inc
}

src_compile() {
	if use ocamlopt; then
		emake
	else
		emake OCAMLC=ocamlc OCAMLOPT=ocamlopt out
		# If using bytecode we dont want to strip the binary as it would remove
		# the bytecode and only leave ocamlrun...
		export STRIP_MASK="*/bin/*"
	fi
}

src_install() {
	make distrib
	cd distribution/gw
	# Install doc
	dodoc CHANGES.txt
	# Install binaries
	dobin gwc gwc1 gwc2 consang gwd gwu update_nldb ged2gwb gwb2ged gwsetup
	insinto /usr/lib/${PN}
	doins -r gwtp_tmp/*
	dodoc a.gwf
	insinto /usr/share/${PN}
	doins -r css etc images lang setup gwd.arg only.txt

	cd ../..

	# Install binaries
	dobin src/check_base
	# Install manpages
	doman man/*

	# Install doc
	insinto /usr/share/doc/${PF}/contrib
	doins -r contrib/{gwdiff,misc}

	newinitd "${FILESDIR}/geneweb.initd" geneweb
	newconfd "${FILESDIR}/geneweb.confd" geneweb
}

pkg_postinst() {
	enewuser geneweb "" "/bin/bash" /var/lib/geneweb
	einfo "A CGI program has been installed in /usr/lib/${PN}. Follow the"
	einfo "instructions on the README in that directory to use it"
}
