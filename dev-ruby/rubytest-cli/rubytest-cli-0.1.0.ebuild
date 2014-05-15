# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubytest-cli/rubytest-cli-0.1.0.ebuild,v 1.1 2014/05/15 18:13:58 p8952 Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Rubytest CLI is a command-line interface for Rubytest"
HOMEPAGE="https://rubyworks.github.io/rubytest-cli/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/ansi >=dev-ruby/rubytest-0.7.0"
