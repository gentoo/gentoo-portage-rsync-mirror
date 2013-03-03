# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/climate_control/climate_control-0.0.3.ebuild,v 1.2 2013/03/03 20:14:58 graaff Exp $

EAPI=5
# uses 1.9 syntax
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="NEWS README.md"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Easily manage your environment"
HOMEPAGE="https://github.com/thoughtbot/climate_control"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/activesupport-3.0"
