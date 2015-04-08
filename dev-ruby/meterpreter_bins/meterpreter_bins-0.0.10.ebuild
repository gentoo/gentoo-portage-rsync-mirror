# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/meterpreter_bins/meterpreter_bins-0.0.10.ebuild,v 1.2 2015/03/22 16:53:51 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRAINSTALL="meterpreter"

inherit ruby-fakegem

DESCRIPTION="Compiled binaries for Metasploit's Meterpreter"
HOMEPAGE="https://github.com/rapid7/meterpreter_bins"

#https://github.com/rapid7/meterpreter_bins/issues/5
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

#no tests
RESTRICT=test
