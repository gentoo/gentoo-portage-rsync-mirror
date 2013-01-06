# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Next/File-Next-1.100.0.ebuild,v 1.3 2012/09/12 10:56:58 johu Exp $

EAPI=4

MODULE_AUTHOR=PETDANCE
MODULE_VERSION=1.10
inherit perl-module

DESCRIPTION="File::Next is an iterator-based module for finding files"

SLOT="0"
KEYWORDS="amd64 x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="virtual/perl-File-Spec
	virtual/perl-Test-Simple"
DEPEND="
	test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
