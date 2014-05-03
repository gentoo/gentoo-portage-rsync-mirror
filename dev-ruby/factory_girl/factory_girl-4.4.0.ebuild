# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/factory_girl/factory_girl-4.4.0.ebuild,v 1.1 2014/05/03 06:14:32 graaff Exp $

EAPI=5

USE_RUBY="ruby19"

RUBY_FAKEGEM_RECIPE_DOC="yard"

# Tests depend on unpackaged appraisal
RUBY_FAKEGEM_RECIPE_TEST=""

RUBY_FAKEGEM_EXTRADOC="GETTING_STARTED.md NEWS README.md"

RUBY_FAKEGEM_EXTRAINSTALL="features"

inherit ruby-fakegem

DESCRIPTION="factory_girl provides a framework and DSL for defining and using factories"
HOMEPAGE="https://github.com/thoughtbot/factory_girl"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/activesupport-3.0.0"
