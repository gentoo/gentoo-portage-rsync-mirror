# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/geneweb/geneweb-5.02.ebuild,v 1.6 2012/06/01 01:56:55 zmedico Exp $

EAPI=2
inherit eutils user

DESCRIPTION="Genealogy software program with a Web interface."
HOMEPAGE="http://cristal.inria.fr/~ddr/GeneWeb/"
SRC_URI="ftp://ftp.inria.fr/INRIA/Projects/cristal/${PN}/Src/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+ocamlopt"

RDEPEND="dev-lang/ocaml[ocamlopt?]
	dev-ml/camlp5"
DEPEND="${RDEPEND}
	!net-p2p/ghostwhitecrab"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-amd64.patch \
		"${FILESDIR}"/${P}-parallellbuild.patch
	sed -i -e "s:@GENTOO_DATADIR@:/usr/share/${PN}:" \
		setup/setup.ml || die "Failed sed for gentoo path"
	rm -f contrib/gwdiff/.{cvsignore,depend}
}

src_compile() {
	if use ocamlopt; then
		emake || die "Compiling native code executables failed"
	else
		emake OCAMLC=ocamlc OCAMLOPT=ocamlopt out \
			|| die "Compiling byte code executables failed"
		# If using bytecode we dont want to strip the binary as it would remove
		# the bytecode and only leave ocamlrun...
		export STRIP_MASK="*/bin/*"
	fi
}

src_install() {
	make distrib || die "Failed making distrib"
	cd distribution/gw
	# Install doc
	dodoc CHANGES.txt
	# Install binaries
	dobin gwc gwc2 consang gwd gwu update_nldb ged2gwb gwb2ged gwsetup \
		|| die "Failed installing binaries"
	insinto /usr/lib/${PN}
	doins -r gwtp_tmp/* || die "Failed installing CGI program"
	dodoc a.gwf
	dohtml -r doc/*
	insinto /usr/share/${PN}
	doins -r etc images lang setup gwd.arg only.txt\
		|| die "Failed installing data"

	cd ../..

	# Install binaries
	dobin src/check_base \
		|| die "Failed installing check_base binaries"
	# Install manpages
	doman man/* || die "Failed installing man pages"

	# Install doc
	dodoc ICHANGES
	insinto /usr/share/doc/${PF}/contrib
	doins -r contrib/{gwdiff,misc} \
		|| die "Failed installing contributions"

	newinitd "${FILESDIR}/geneweb.initd" geneweb
	newconfd "${FILESDIR}/geneweb.confd" geneweb
}

pkg_postinst() {
	enewuser geneweb "" "/bin/bash" /var/lib/geneweb
	einfo "A CGI program has been installed in /usr/lib/${PN}. Follow the"
	einfo "instructions on the README in that directory to use it"
}
