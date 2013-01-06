# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-FormBuilder/CGI-FormBuilder-3.50.100.ebuild,v 1.1 2011/09/01 12:52:31 tove Exp $

EAPI=4

MODULE_AUTHOR=NWIGER
MODULE_VERSION=3.0501
MODULE_A_EXT=tgz
inherit perl-module

DESCRIPTION="Extremely fast, reliable form generation and processing module"
HOMEPAGE="http://www.formbuilder.org/ ${HOMEPAGE}"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Templates that can be used - but they are optional
#	>=dev-perl/HTML-Template-2.06
#	>=dev-perl/text-template-1.43
#	>=dev-perl/CGI-FastTemplate-1.09
#	>=dev-perl/Template-Toolkit-2.08

SRC_TEST=do
