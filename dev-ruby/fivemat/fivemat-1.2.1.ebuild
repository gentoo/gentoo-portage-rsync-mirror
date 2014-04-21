# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fivemat/fivemat-1.2.1.ebuild,v 1.1 2014/04/21 17:49:47 zerochaos Exp $

EAPI=5
USE_RUBY="ruby19"

#RUBY_FAKEGEM_RECIPE_DOC="rdoc"
#RUBY_FAKEGEM_DOCDIR="doc"
#RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="MiniTest/RSpec/Cucumber formatter that gives each test file its own line of dots"
HOMEPAGE="https://github.com/tpope/fivemat"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#tests fail missing .git directory
RESTRICT=test
