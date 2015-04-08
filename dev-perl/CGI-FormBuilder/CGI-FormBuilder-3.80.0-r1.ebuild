# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-FormBuilder/CGI-FormBuilder-3.80.0-r1.ebuild,v 1.1 2014/08/26 15:00:39 axs Exp $

EAPI=5

MODULE_AUTHOR=NWIGER
MODULE_VERSION=3.08
MODULE_A_EXT=tgz
inherit perl-module

DESCRIPTION="Extremely fast, reliable form generation and processing module"
HOMEPAGE="http://www.formbuilder.org/ ${HOMEPAGE}"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Templates that can be used - but they are optional
#	>=dev-perl/HTML-Template-2.60.0
#	>=dev-perl/text-template-1.430.0
#	>=dev-perl/CGI-FastTemplate-1.90.0
#	>=dev-perl/Template-Toolkit-2.80.0
#	>=dev-perl/CGI-SSI-0.920.0

SRC_TEST=do
