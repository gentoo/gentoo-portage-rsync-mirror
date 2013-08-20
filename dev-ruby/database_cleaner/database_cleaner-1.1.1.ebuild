# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/database_cleaner/database_cleaner-1.1.1.ebuild,v 1.1 2013/08/20 03:58:12 zerochaos Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_RECIPE_TEST=""

inherit ruby-fakegem

DESCRIPTION="Strategies for cleaning databases"
HOMEPAGE="http://github.com/bmabey/database_cleaner"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
