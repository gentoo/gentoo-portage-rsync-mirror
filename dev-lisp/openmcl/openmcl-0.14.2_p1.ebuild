# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/openmcl/openmcl-0.14.2_p1.ebuild,v 1.6 2012/04/07 10:40:42 neurogeek Exp $

inherit eutils common-lisp-common-2

EXTRA_PV=o
MY_PV=${PV/_p/.p}

DESCRIPTION="OpenMCL is a Common Lisp implementation, derived from Digitool's MCL  product"
HOMEPAGE="http://openmcl.clozure.com/
	http://packages.debian.org/unstable/devel/openmcl"
SRC_URI="mirror://debian/pool/main/o/${PN}/${PN}_${MY_PV}.${EXTRA_PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND="=dev-lisp/common-lisp-controller-4*
	>=dev-lisp/asdf-1.84
	dev-lisp/openmcl-build-tools"

S=${WORKDIR}/${PN}-${MY_PV}

# The following relies heavily on what I read in debian/rules...

src_unpack() {
	unpack ${A}
	pushd ${S}
	sed -e "s,%ver%,${MY_PV}.${EXTRA_PV}," \
		< debian/run-bootstrap.lisp.template \
		> debian/run-bootstrap.lisp
	cp debian/Makefile .
	cp -RP /usr/lib/openmcl/{PPCCL-orig,headers} .
	epatch "${FILESDIR}/prototype_print_lisp_object.diff"
	popd
}

src_compile() {
	OPENMCL=/usr/bin/openmcl make || die
}

src_install() {
	dodir /etc
	dodir /usr/bin
	dodir /usr/lib/common-lisp/bin
	dodir /usr/lib/openmcl
	dodir /usr/lib/openmcl/lib
	dodir /usr/lib/openmcl/library
	make install DESTDIR=${D} || die
	insinto /usr/lib/openmcl
	doins debian/install-clc.lisp
	exeinto /usr/lib/common-lisp/bin/
	doexe debian/openmcl.sh
	dohtml doc/HTML/*.html
	doman debian/openmcl.1
	do-debian-credits
}

pkg_postinst() {
	standard-impl-postinst openmcl || die
}

pkg_postrm() {
	standard-impl-postrm openmcl /usr/bin/openmcl
	if [ ! -x /usr/bin/openmcl ]; then
		rm -rf /usr/lib/openmcl/ || die
	fi
}
