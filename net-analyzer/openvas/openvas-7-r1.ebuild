# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas/openvas-7-r1.ebuild,v 1.3 2014/10/01 16:04:07 jlec Exp $

EAPI=5

inherit readme.gentoo

DESCRIPTION="A remote security scanner"
HOMEPAGE="http://www.openvas.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="pdf"

DEPEND="
	>=net-analyzer/openvas-libraries-7.0.4-r1
	>=net-analyzer/openvas-scanner-4.0.3-r2
	>=net-analyzer/openvas-manager-5.0.4-r2
	>=net-analyzer/openvas-cli-1.3.0-r1
	net-analyzer/openvas-tools
	>=net-analyzer/greenbone-security-assistant-5.0.3-r1
	pdf? (
		virtual/latex-base
		app-text/htmldoc
	)"
# greenbone-security-desktop is broken and unsupported upstream
RDEPEND="${DEPEND}"

S="${WORKDIR}"
