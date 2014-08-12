# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ansi/ansi-1.4.3.ebuild,v 1.3 2014/08/12 12:58:46 blueness Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_RECIPE_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="The Ruby ANSI project is collection of ANSI escape codes for Ruby"
HOMEPAGE="https://rubyworks.github.io/ansi/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64"
IUSE=""

# Tests cause circular dependencies with dev-ruby/qed & dev-ruby/rubytest
RESTRICT="test"
