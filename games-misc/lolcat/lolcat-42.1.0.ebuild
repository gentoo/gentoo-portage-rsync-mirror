# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/lolcat/lolcat-42.1.0.ebuild,v 1.2 2015/02/06 10:12:08 mr_bones_ Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Rainbows and unicorns!"
HOMEPAGE="https://github.com/busyloop/lolcat"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

ruby_add_rdepend ">=dev-ruby/trollop-1.16.2-r3:0
	dev-ruby/paint"
