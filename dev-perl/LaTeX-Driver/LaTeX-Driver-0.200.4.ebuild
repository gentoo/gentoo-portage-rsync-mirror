# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LaTeX-Driver/LaTeX-Driver-0.200.4.ebuild,v 1.3 2014/11/11 11:54:51 blueness Exp $

EAPI=5

MODULE_AUTHOR=EINHVERFR
MODULE_VERSION=0.200.4
inherit perl-module

DESCRIPTION="Perl encapsulation of invoking the Latex programs"

LICENSE="|| ( GPL-1+ Artistic )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Class-Accessor
	dev-perl/Exception-Class
	dev-perl/File-Slurp
	virtual/perl-File-Spec
	dev-perl/File-pushd
	virtual/perl-Getopt-Long
	dev-perl/Readonly
	virtual/perl-parent
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
SRC_TEST="do"
