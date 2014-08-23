# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Object/Test-Object-0.70.0-r1.ebuild,v 1.1 2014/08/23 02:17:53 axs Exp $

EAPI=5

MODULE_AUTHOR=ADAMK
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="Thoroughly testing objects via registered handlers"

SLOT="0"
KEYWORDS="amd64 ~arm ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="virtual/perl-File-Spec
	virtual/perl-Scalar-List-Utils
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}"

SRC_TEST="do"
