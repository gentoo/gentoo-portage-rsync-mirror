# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-WorkflowEventLogTiein/ezc-WorkflowEventLogTiein-1.1.ebuild,v 1.1 2011/12/14 22:28:32 mabi Exp $

EZC_BASE_MIN="1.4"
inherit php-ezc

DESCRIPTION="This eZ component contains the EventLog listener for the Workflow component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-EventLog-1.1
	>=dev-php/ezc-Workflow-1.0.1"
