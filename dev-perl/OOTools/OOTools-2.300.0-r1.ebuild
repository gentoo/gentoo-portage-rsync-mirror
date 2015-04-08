# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OOTools/OOTools-2.300.0-r1.ebuild,v 1.2 2014/11/01 22:36:44 monsieurp Exp $

EAPI=5

MODULE_AUTHOR=SKNPP
MODULE_VERSION=2.3
inherit perl-module

DESCRIPTION="Pragma to implement lvalue accessors with options"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/${CATEGORY}/${PN}/${P}-patch.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	virtual/perl-Module-Build
"

SRC_TEST=do

EPATCH_SUFFIX=patch
PATCHES=(
	"${WORKDIR}"/${MY_PN:-${PN}}-patch
)
src_prepare() {
	einfo "Removing unwanted author tests"
	rm -f "${S}/t/test_pod.t"
	rm -f "${S}/t/test_pod_coverage.t"
	# This silences warnings by EUMM about missing files.
	grep -v '^t/test_pod' "${S}/MANIFEST" > "${S}/MANIFEST.tmp"
	mv -f -- "${S}/MANIFEST.tmp" "${S}/MANIFEST"
}
