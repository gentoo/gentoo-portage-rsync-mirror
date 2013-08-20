# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/shoulda-matchers/shoulda-matchers-2.3.0.ebuild,v 1.1 2013/08/20 04:11:15 zerochaos Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_RECIPE_TEST=""

#RUBY_FAKEGEM_EXTRAINSTALL="app db script spec"

inherit ruby-fakegem

DESCRIPTION="Making tests easy on the fingers and eyes"
HOMEPAGE="https://github.com/thoughtbot/shoulda-matchers"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/activesupport-3.0.0"
