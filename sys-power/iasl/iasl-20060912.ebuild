# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/iasl/iasl-20060912.ebuild,v 1.8 2011/09/30 16:56:57 vapier Exp $

inherit toolchain-funcs eutils

MY_PN=acpica-unix
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Intel ACPI Source Language (ASL) compiler"
HOMEPAGE="http://www.intel.com/technology/iapc/acpi/"
SRC_URI="http://www.intel.com/technology/iapc/acpi/downloads/${MY_P}.tar.gz"

LICENSE="iASL"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-devel/bison
	sys-devel/flex"
RDEPEND=""

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${MY_PN}-20060512-buildfixup.patch
}

src_compile() {
	# fix stupid flex 2.5.31 bug
	emake -C compiler aslcompilerlex.c || die "emake aslcompilerlex.c failed"
	sed -i.orig -e '/#define unput/s,yytext_ptr,AslCompilertext,' \
		"${S}"/compiler/aslcompilerlex.c || die "sed failed"
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin compiler/iasl tools/acpixtract/acpixtract tools/acpiexec/acpiexec tools/acpisrc/acpisrc
	dodoc README changes.txt
}
