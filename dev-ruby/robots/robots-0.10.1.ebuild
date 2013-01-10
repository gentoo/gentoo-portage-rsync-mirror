# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/robots/robots-0.10.1.ebuild,v 1.1 2013/01/10 04:23:23 zerochaos Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST=""

inherit ruby-fakegem

DESCRIPTION="The database layer for Metasploit"
HOMEPAGE="https://rubygems.org/gems/robots"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
