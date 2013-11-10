# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas/openvas-6_p1.ebuild,v 1.1 2013/11/10 18:42:52 hanno Exp $

EAPI=5

DESCRIPTION="A remote security scanner"
HOMEPAGE="http://www.openvas.org/"
DEPEND=">=net-analyzer/openvas-libraries-6.0.1
	>=net-analyzer/openvas-scanner-3.4.0
	>=net-analyzer/openvas-manager-4.0.4
	>=net-analyzer/openvas-administrator-1.3.2
	>=net-analyzer/openvas-cli-1.2.0
	>=net-analyzer/greenbone-security-assistant-4.0.2"
# greenbone-security-desktop is broken and unsupported upstream
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
