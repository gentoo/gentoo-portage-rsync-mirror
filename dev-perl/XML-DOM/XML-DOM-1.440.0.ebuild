# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM/XML-DOM-1.440.0.ebuild,v 1.3 2012/05/18 09:16:52 aballier Exp $

EAPI=4

MODULE_AUTHOR=TJMATHER
MODULE_VERSION=1.44
inherit perl-module

DESCRIPTION="A Perl module for an DOM Level 1 compliant interface"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/libwww-perl
	>=dev-perl/libxml-perl-0.07
	>=dev-perl/XML-Parser-2.30
	dev-perl/XML-RegExp"
DEPEND="${RDEPEND}"
