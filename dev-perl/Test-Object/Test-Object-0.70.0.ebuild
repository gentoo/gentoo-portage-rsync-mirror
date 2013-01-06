# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Object/Test-Object-0.70.0.ebuild,v 1.2 2011/09/03 21:04:35 tove Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="Thoroughly testing objects via registered handlers"

SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="virtual/perl-File-Spec
	virtual/perl-Scalar-List-Utils
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}"

SRC_TEST="do"
