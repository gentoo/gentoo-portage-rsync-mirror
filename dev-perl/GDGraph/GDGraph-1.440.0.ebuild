# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDGraph/GDGraph-1.440.0.ebuild,v 1.2 2011/09/03 21:04:51 tove Exp $

EAPI=4

MODULE_AUTHOR=BWARFIELD
MODULE_VERSION=1.44
inherit perl-module

DESCRIPTION="Perl5 module to create charts using the GD module"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/GDTextUtil
	dev-perl/GD
	media-libs/gd"
DEPEND="${RDEPEND}"
