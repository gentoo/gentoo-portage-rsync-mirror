# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/multi_test/multi_test-0.1.2.ebuild,v 1.2 2015/03/22 17:03:23 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_EXTRADOC="History.md README.md"

inherit ruby-fakegem

DESCRIPTION="A uniform interface for Ruby testing libraries"
HOMEPAGE="http://cukes.info/"
LICENSE="MIT"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE=""

# Tests depend on specific versions of testing frameworks where bundler
# downloads dependencies.
RESTRICT="test"
